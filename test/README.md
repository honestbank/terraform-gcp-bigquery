# Automated Tests - Terraform Component Modules for Google BigQuery

This repository utilizes [Terratest](https://terratest.gruntwork.io) for automated testing.

## Running a Subset of Tests

### Specific File

```shell
$ go test foo_test.go -v -timeout 30m
```

### Specific Test Case

```shell

# Matches all tests that contain `NameOfTest`
$ go test -v -timeout 30m -run NameOfTest

# Matches test case name exactly
$ go test -v -timeout 30m -run "^NameOfTest$"
```
