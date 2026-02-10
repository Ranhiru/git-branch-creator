# Git Branch Creator

This script can be used to create a git branch with a simplified name

E.g Given **JIRA 12212 FE - Consumer Portal - Pay now/Payment methods/Order details** the script will convert it to
`jira-12212-fe-consumer-portal-pay-now-payment-methods-order-details` and create a git branch with that name in the current directory.

For more examples, see the tests in the `spec` directory.

# Configuration

Create a config file at `~/git_branch_creator.yml` with your JIRA credentials:

```yaml
username: "your-email@example.com"
password: "your-api-token"
apiHost: "https://your-company.atlassian.net"
```

Ensure the file has secure permissions:

```bash
chmod 600 ~/git_branch_creator.yml
```

# Usage

`./git-branch-creator "Your input"`

# Running Tests

* `bundle install`
* `rspec spec/`

# Make Targets

This repository includes a `Makefile` for common tasks:

* `make setup` - install gems (`bundle install`).
* `make test` - run the test suite (`bundle exec rspec spec/`).
* `make symlink` - create/update a symlink at `~/.local/bin/git-branch-creator`.

Optional override for symlink destination:

* `make symlink INSTALL_DIR=/usr/local/bin`

Optional override for Ruby toolchain command:

* `make setup BUNDLE="asdf exec bundle"`
* `make test BUNDLE="asdf exec bundle"`
