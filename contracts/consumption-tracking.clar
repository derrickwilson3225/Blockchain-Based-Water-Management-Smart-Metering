;; Consumption Tracking Contract
;; Tracks water consumption for smart meters

(define-constant ERR_UNAUTHORIZED (err u200))
(define-constant ERR_METER_NOT_FOUND (err u201))
(define-constant ERR_INVALID_READING (err u202))

;; Data structures
(define-map meters
  { meter-id: uint }
  {
    owner: principal,
    utility-id: uint,
    installation-date: uint,
    is-active: bool,
    location: (string-ascii 100)
  }
)

(define-map consumption-readings
  { meter-id: uint, reading-id: uint }
  {
    reading-value: uint,
    timestamp: uint,
    previous-reading: uint,
    consumption-amount: uint
  }
)

(define-map meter-reading-count
  { meter-id: uint }
  { count: uint }
)

(define-data-var next-meter-id uint u1)

;; Public functions
(define-public (register-meter (owner principal) (utility-id uint) (location (string-ascii 100)))
  (let ((meter-id (var-get next-meter-id)))
    (map-set meters
      { meter-id: meter-id }
      {
        owner: owner,
        utility-id: utility-id,
        installation-date: block-height,
        is-active: true,
        location: location
      }
    )

    (map-set meter-reading-count { meter-id: meter-id } { count: u0 })
    (var-set next-meter-id (+ meter-id u1))
    (ok meter-id)
  )
)

(define-public (record-consumption (meter-id uint) (reading-value uint))
  (let (
    (meter (unwrap! (map-get? meters { meter-id: meter-id }) ERR_METER_NOT_FOUND))
    (reading-count (default-to { count: u0 } (map-get? meter-reading-count { meter-id: meter-id })))
    (reading-id (+ (get count reading-count) u1))
    (previous-reading (get-last-reading meter-id))
    (consumption (if (> reading-value previous-reading) (- reading-value previous-reading) u0))
  )
    (asserts! (get is-active meter) ERR_UNAUTHORIZED)
    (asserts! (> reading-value u0) ERR_INVALID_READING)

    (map-set consumption-readings
      { meter-id: meter-id, reading-id: reading-id }
      {
        reading-value: reading-value,
        timestamp: block-height,
        previous-reading: previous-reading,
        consumption-amount: consumption
      }
    )

    (map-set meter-reading-count { meter-id: meter-id } { count: reading-id })
    (ok consumption)
  )
)

;; Read-only functions
(define-read-only (get-meter (meter-id uint))
  (map-get? meters { meter-id: meter-id })
)

(define-read-only (get-consumption-reading (meter-id uint) (reading-id uint))
  (map-get? consumption-readings { meter-id: meter-id, reading-id: reading-id })
)

(define-read-only (get-last-reading (meter-id uint))
  (let ((reading-count (default-to { count: u0 } (map-get? meter-reading-count { meter-id: meter-id }))))
    (if (> (get count reading-count) u0)
      (match (map-get? consumption-readings { meter-id: meter-id, reading-id: (get count reading-count) })
        reading (get reading-value reading)
        u0
      )
      u0
    )
  )
)

(define-read-only (get-total-consumption (meter-id uint))
  (let ((reading-count (default-to { count: u0 } (map-get? meter-reading-count { meter-id: meter-id }))))
    (fold + (map get-reading-consumption (generate-sequence u1 (get count reading-count))) u0)
  )
)

(define-private (get-reading-consumption (reading-id uint))
  u0 ;; Simplified for demo
)

(define-private (generate-sequence (start uint) (end uint))
  (list u1 u2 u3 u4 u5) ;; Simplified sequence
)
