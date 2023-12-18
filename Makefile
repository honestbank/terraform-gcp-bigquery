lint:
	terraform fmt --recursive

validate:
	terraform init
	terraform validate
	terraform fmt --recursive

docs:
	terraform-docs  --lockfile=false -c .terraform-docs.yml .
	cd examples/gcp_bigquery_big_lake_table/; terraform-docs --lockfile=false -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_cloudsql_connection/; terraform-docs --lockfile=false -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_dataset/; terraform-docs --lockfile=false -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_dataset_iam_policy/; terraform-docs --lockfile=false -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_masked_dataset/; terraform-docs --lockfile=false -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_masked_table/; terraform-docs --lockfile=false -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_table/; terraform-docs --lockfile=false -c .terraform-docs.yml .;
	cd examples/gcp_bigquery_view/; terraform-docs --lockfile=false -c .terraform-docs.yml .;

test_and_cover:
	cd test; go test -v -race -covermode=atomic -timeout 90m ./...
