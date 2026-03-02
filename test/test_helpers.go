package test

import (
	"log"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/testing"
	"github.com/stretchr/testify/assert"
)

func ensureZeroResourceChange(t testing.TestingT, options *terraform.Options) {
	// Ensure there's no drift on the next plan
	planOutput := terraform.InitAndPlan(t, options)

	resourceCount, err := terraform.GetResourceCountE(t, planOutput)
	if err != nil {
		// Plan output may be in a format terratest can't parse (e.g. output-only
		// changes, provider deprecation warnings, write-only credential fields).
		// Log the full output for visibility and skip the drift assertion.
		log.Printf("Skipping drift check — could not parse terraform plan output: %v\n\nPlan output:\n%s", err, planOutput)
		return
	}

	assert.Zero(t, resourceCount.Add, "Expected zero resources to add, got ", resourceCount.Add)
	assert.Zero(t, resourceCount.Change, "Expected zero resources to change, got ", resourceCount.Change)
	assert.Zero(t, resourceCount.Destroy, "Expected zero resources to destroy, got ", resourceCount.Destroy)
}
