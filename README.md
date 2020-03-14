# Git Branch Creator

This script can be used to create a git branch with a simplified name

E.g Given **JIRA 12212 FE - Consumer Portal - Pay now/Payment methods/Order details** the script will convert it to
`jira-12212-fe-consumer-portal-pay-now-payment-methods-order-details` and create a git branch with that name in the current directory.

For more examples, see the tests in the `spec` directory.

# Usage

`./git-branch-creator "Your input"`

# Running Tests

* `bundle install`
* `rspec spec/`
