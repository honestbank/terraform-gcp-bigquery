lint:
	terraform fmt --recursive

validate:
	terraform init
	terraform validate
	terraform fmt --recursive

docs:
	rm -rf modules/*/.terraform modules/*/.terraform.lock.hcl
	rm -rf examples/*/.terraform examples/*/.terraform.lock.hcl
	terraform-docs -c .terraform-docs.yml .
	cd examples/gcp_bigquery_big_lake_table/; terraform-docs -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_cloudsql_connection/; terraform-docs -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_dataset/; terraform-docs -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_dataset_iam_policy/; terraform-docs -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_masked_dataset/; terraform-docs -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_masked_table/; terraform-docs -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_table/; terraform-docs -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_view/; terraform-docs -c .terraform-docs.yml .;

test_and_cover:
	cd test; go test -v -race -covermode=atomic -timeout 90m ./...
