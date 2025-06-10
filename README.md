# Blockchain-Based Water Management Smart Metering System

A comprehensive blockchain solution for water utility management using Clarity smart contracts on the Stacks blockchain.

## Overview

This system provides a decentralized platform for water utility companies to manage smart meters, track consumption, automate billing, detect leaks, and incentivize conservation efforts.

## Features

### 🏢 Utility Verification
- Register and validate water utility companies
- Manage utility licenses and credentials
- Activate/deactivate utility status

### 📊 Consumption Tracking
- Register smart water meters
- Record real-time consumption readings
- Track historical usage patterns
- Calculate consumption differences

### 💰 Billing Automation
- Set tiered billing rates
- Generate automated bills based on consumption
- Process payments securely
- Track payment history

### 🚨 Leak Detection
- Set consumption thresholds for leak detection
- Detect spike and continuous leaks
- Classify leak severity levels
- Track leak resolution status

### 🌱 Conservation Incentives
- Set conservation targets for customers
- Reward customers for meeting targets
- Track conservation streaks
- Manage reward claims

## Smart Contracts

### 1. Utility Verification Contract (`utility-verification.clar`)
Manages the registration and validation of water utility companies.

**Key Functions:**
- `register-utility`: Register a new utility company
- `deactivate-utility`: Deactivate a utility
- `get-utility`: Get utility information
- `is-utility-active`: Check if utility is active

### 2. Consumption Tracking Contract (`consumption-tracking.clar`)
Tracks water consumption from smart meters.

**Key Functions:**
- `register-meter`: Register a new smart meter
- `record-consumption`: Record consumption reading
- `get-meter`: Get meter information
- `get-consumption-reading`: Get specific reading
- `get-last-reading`: Get most recent reading

### 3. Billing Automation Contract (`billing-automation.clar`)
Automates the billing process based on consumption data.

**Key Functions:**
- `set-billing-rate`: Set utility billing rates
- `generate-bill`: Create a new bill
- `pay-bill`: Process bill payment
- `get-bill`: Get bill information
- `calculate-bill-amount`: Calculate bill amount

### 4. Leak Detection Contract (`leak-detection.clar`)
Detects potential water leaks based on consumption patterns.

**Key Functions:**
- `set-leak-threshold`: Set leak detection thresholds
- `check-for-leak`: Check for potential leaks
- `resolve-leak`: Mark leak as resolved
- `get-leak`: Get leak information

### 5. Conservation Incentive Contract (`conservation-incentive.clar`)
Provides incentives for water conservation.

**Key Functions:**
- `set-conservation-target`: Set conservation goals
- `update-consumption`: Update consumption and check targets
- `claim-reward`: Claim conservation rewards
- `get-reward`: Get reward information
- `get-customer-stats`: Get customer conservation statistics

## Installation

1. Clone the repository:
   \`\`\`bash
   git clone https://github.com/your-repo/water-management-blockchain.git
   cd water-management-blockchain
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

## Usage

### Deploying Contracts

Deploy the contracts in the following order:

1. Utility Verification Contract
2. Consumption Tracking Contract
3. Billing Automation Contract
4. Leak Detection Contract
5. Conservation Incentive Contract

### Basic Workflow

1. **Utility Registration**: Register your water utility company
2. **Meter Installation**: Register smart meters for customers
3. **Rate Setting**: Configure billing rates and leak thresholds
4. **Data Collection**: Record consumption readings from meters
5. **Automated Processing**: System automatically generates bills and detects leaks
6. **Conservation Programs**: Set targets and reward conservation efforts

## Testing

The project includes comprehensive tests using Vitest:

\`\`\`bash
# Run all tests
npm test

# Run specific test file
npm test utility-verification.test.js

# Run tests in watch mode
npm run test:watch
\`\`\`

## Error Codes

### Utility Verification (100-199)
- `100`: Unauthorized access
- `101`: Utility already exists
- `102`: Utility not found
- `103`: Utility not active

### Consumption Tracking (200-299)
- `200`: Unauthorized access
- `201`: Meter not found
- `202`: Invalid reading

### Billing Automation (300-399)
- `300`: Unauthorized access
- `301`: Bill not found
- `302`: Bill already paid
- `303`: Insufficient payment

### Leak Detection (400-499)
- `400`: Unauthorized access
- `401`: Invalid threshold
- `402`: Leak not found

### Conservation Incentive (500-599)
- `500`: Unauthorized access
- `501`: Invalid target
- `502`: Reward not found
- `503`: Already claimed

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Run the test suite
6. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please open an issue in the GitHub repository.

## Roadmap

- [ ] Integration with IoT water meters
- [ ] Mobile app for customers
- [ ] Advanced analytics dashboard
- [ ] Multi-utility support
- [ ] Integration with payment gateways
- [ ] Real-time notifications
- [ ] Water quality monitoring
- [ ] Predictive maintenance
  \`\`\`

Finally, let's create the PR details file:
