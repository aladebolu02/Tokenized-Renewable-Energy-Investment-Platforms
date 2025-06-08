# Tokenized Renewable Energy Investment Platform

A comprehensive blockchain-based platform for managing renewable energy investments, built on the Stacks blockchain using Clarity smart contracts.

## Overview

This platform enables tokenized investments in renewable energy projects, providing transparent tracking of project performance, automated revenue distribution, and comprehensive risk assessment tools.

## Features

### 🏗️ Developer Verification System
- Validates renewable energy project developers
- Tracks developer reputation and project history
- Ensures only verified developers can create projects

### 💰 Investment Management
- Create and manage renewable energy investment projects
- Set minimum investment thresholds and funding targets
- Track investment progress and manage project lifecycle

### 📊 Performance Tracking
- Monitor real-time energy generation metrics
- Track efficiency ratings and carbon offset impact
- Maintain historical performance data

### 💸 Revenue Distribution
- Automated revenue distribution to token holders
- Transparent calculation of returns based on token ownership
- Secure claiming mechanism for investors

### ⚠️ Risk Assessment
- Comprehensive risk evaluation across multiple factors
- Technology, market, regulatory, environmental, and financial risk analysis
- Historical risk tracking and recommendations

## Smart Contracts

### 1. Developer Verification Contract (\`developer-verification.clar\`)
Manages the registration and verification of renewable energy project developers.

**Key Functions:**
- \`register-developer\`: Register a new developer
- \`verify-developer\`: Verify a developer (owner only)
- \`get-developer\`: Retrieve developer information
- \`update-reputation\`: Update developer reputation score

### 2. Investment Management Contract (\`investment-management.clar\`)
Handles the creation and management of investment projects.

**Key Functions:**
- \`create-project\`: Create a new investment project
- \`invest\`: Invest in a project
- \`close-project\`: Close project funding
- \`get-project\`: Retrieve project details

### 3. Performance Tracking Contract (\`performance-tracking.clar\`)
Tracks and stores renewable energy project performance metrics.

**Key Functions:**
- \`record-performance\`: Record performance metrics
- \`get-period-performance\`: Get performance for specific period
- \`get-project-stats\`: Get overall project statistics
- \`calculate-efficiency\`: Calculate efficiency percentage

### 4. Revenue Distribution Contract (\`revenue-distribution.clar\`)
Manages revenue distribution to investors based on token ownership.

**Key Functions:**
- \`record-revenue\`: Record revenue for distribution
- \`distribute-revenue\`: Calculate and distribute revenue
- \`claim-revenue\`: Claim revenue (for investors)
- \`set-token-supply\`: Set project token supply

### 5. Risk Assessment Contract (\`risk-assessment.clar\`)
Provides comprehensive risk assessment for renewable energy projects.

**Key Functions:**
- \`assess-risks\`: Assess project risks across multiple factors
- \`get-risk-assessment\`: Get current risk assessment
- \`get-risk-recommendation\`: Get investment recommendation
- \`update-risk-factor\`: Update individual risk factors

## Getting Started

### Prerequisites
- Stacks blockchain development environment
- Clarity CLI tools
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd renewable-energy-platform
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

Deploy contracts to Stacks blockchain:

\`\`\`bash
# Deploy developer verification contract
clarinet deploy contracts/developer-verification.clar

# Deploy investment management contract
clarinet deploy contracts/investment-management.clar

# Deploy performance tracking contract
clarinet deploy contracts/performance-tracking.clar

# Deploy revenue distribution contract
clarinet deploy contracts/revenue-distribution.clar

# Deploy risk assessment contract
clarinet deploy contracts/risk-assessment.clar
\`\`\`

## Usage Examples

### Register and Verify a Developer

\`\`\`clarity
;; Register a new developer
(contract-call? .developer-verification register-developer "Solar Energy Corp")

;; Verify the developer (owner only)
(contract-call? .developer-verification verify-developer u1)
\`\`\`

### Create an Investment Project

\`\`\`clarity
;; Create a new solar energy project
(contract-call? .investment-management create-project
u1                    ;; developer-id
"Solar Farm Alpha"    ;; project name
u1000000             ;; target amount
u1000                ;; minimum investment
u2000                ;; deadline (block height)
"Solar"              ;; energy type
)
\`\`\`

### Invest in a Project

\`\`\`clarity
;; Invest 5000 tokens in project 1
(contract-call? .investment-management invest u1 u5000)
\`\`\`

### Record Performance Metrics

\`\`\`clarity
;; Record performance for period 1
(contract-call? .performance-tracking record-performance
u1      ;; project-id
u1      ;; period
u50000  ;; energy-generated
u60000  ;; energy-target
u85     ;; efficiency-rating
u25000  ;; carbon-offset
u5000   ;; maintenance-cost
)
\`\`\`

### Assess Project Risks

\`\`\`clarity
;; Assess risks for project 1
(contract-call? .risk-assessment assess-risks
u1    ;; project-id
u20   ;; technology-risk
u30   ;; market-risk
u25   ;; regulatory-risk
u15   ;; environmental-risk
u35   ;; financial-risk
"Initial assessment for solar project"
)
\`\`\`

## Testing

The platform includes comprehensive test suites for all contracts:

\`\`\`bash
# Run all tests
npm test

# Run specific contract tests
npm test developer-verification
npm test investment-management
npm test performance-tracking
npm test revenue-distribution
npm test risk-assessment
\`\`\`

## Risk Levels

The platform categorizes projects into three risk levels:

- **Low Risk** (0-30): Recommended for investment
- **Medium Risk** (31-70): Moderate investment with caution
- **High Risk** (71-100): High risk investment, proceed with extreme caution

## Revenue Distribution Model

Revenue is distributed proportionally based on token ownership:

1. Project generates revenue from energy sales
2. Revenue is recorded in the system
3. Revenue per token is calculated (total revenue / total token supply)
4. Investors can claim their share based on token holdings

## Security Considerations

- All administrative functions are restricted to contract owners
- Input validation prevents invalid data entry
- Error handling provides clear feedback for failed operations
- Historical data is immutable once recorded

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions and support, please open an issue in the GitHub repository.

## Roadmap

- [ ] Integration with real-world energy data feeds
- [ ] Mobile application for investors
- [ ] Advanced analytics dashboard
- [ ] Multi-token support for different project types
- [ ] Governance token for platform decisions
- [ ] Integration with carbon credit markets
