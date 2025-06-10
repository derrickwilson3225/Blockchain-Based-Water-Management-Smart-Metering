;; Billing Automation Contract
;; Automates water billing based on consumption

(define-constant ERR_UNAUTHORIZED (err u300))
(define-constant ERR_BILL_NOT_FOUND (err u301))
(define-constant ERR_BILL_ALREADY_PAID (err u302))
(define-constant ERR_INSUFFICIENT_PAYMENT (err u303))

;; Data structures
(define-map billing-rates
  { utility-id: uint }
  {
    base-rate: uint,
    per-gallon-rate: uint,
    tier1-limit: uint,
    tier2-rate: uint,
    tier3-rate: uint
  }
)

(define-map bills
  { bill-id: uint }
  {
    meter-id: uint,
    utility-id: uint,
    customer: principal,
    consumption: uint,
    amount-due: uint,
    due-date: uint,
    is-paid: bool,
    payment-date: (optional uint)
  }
)

(define-data-var next-bill-id uint u1)

;; Public functions
(define-public (set-billing-rate (utility-id uint) (base-rate uint) (per-gallon-rate uint))
  (begin
    (map-set billing-rates
      { utility-id: utility-id }
      {
        base-rate: base-rate,
        per-gallon-rate: per-gallon-rate,
        tier1-limit: u1000,
        tier2-rate: (+ per-gallon-rate u50),
        tier3-rate: (+ per-gallon-rate u100)
      }
    )
    (ok true)
  )
)

(define-public (generate-bill (meter-id uint) (utility-id uint) (customer principal) (consumption uint))
  (let (
    (bill-id (var-get next-bill-id))
    (rates (unwrap! (map-get? billing-rates { utility-id: utility-id }) ERR_UNAUTHORIZED))
    (amount-due (calculate-bill-amount consumption rates))
  )
    (map-set bills
      { bill-id: bill-id }
      {
        meter-id: meter-id,
        utility-id: utility-id,
        customer: customer,
        consumption: consumption,
        amount-due: amount-due,
        due-date: (+ block-height u720), ;; 30 days
        is-paid: false,
        payment-date: none
      }
    )

    (var-set next-bill-id (+ bill-id u1))
    (ok bill-id)
  )
)

(define-public (pay-bill (bill-id uint) (payment-amount uint))
  (let ((bill (unwrap! (map-get? bills { bill-id: bill-id }) ERR_BILL_NOT_FOUND)))
    (asserts! (is-eq tx-sender (get customer bill)) ERR_UNAUTHORIZED)
    (asserts! (not (get is-paid bill)) ERR_BILL_ALREADY_PAID)
    (asserts! (>= payment-amount (get amount-due bill)) ERR_INSUFFICIENT_PAYMENT)

    (map-set bills
      { bill-id: bill-id }
      (merge bill { is-paid: true, payment-date: (some block-height) })
    )
    (ok true)
  )
)

;; Read-only functions
(define-read-only (get-bill (bill-id uint))
  (map-get? bills { bill-id: bill-id })
)

(define-read-only (calculate-bill-amount (consumption uint) (rates { base-rate: uint, per-gallon-rate: uint, tier1-limit: uint, tier2-rate: uint, tier3-rate: uint }))
  (let ((base (get base-rate rates)))
    (if (<= consumption (get tier1-limit rates))
      (+ base (* consumption (get per-gallon-rate rates)))
      (+ base (* (get tier1-limit rates) (get per-gallon-rate rates))
         (* (- consumption (get tier1-limit rates)) (get tier2-rate rates)))
    )
  )
)
