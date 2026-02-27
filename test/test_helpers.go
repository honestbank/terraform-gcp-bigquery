package test

import (
	"strings"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/testing"
	"github.com/stretchr/testify/assert"
)

func ensureZeroResourceChange(t testing.TestingT, options *terraform.Options) {
	// Ensure there's no drift on the next plan
	planOutput := terraform.InitAndPlan(t, options)

	// Terraform may produce "Changes to Outputs:" only (no resource changes) which
	// terratest's GetResourceCount regex does not handle. Treat this as zero resource
	// changes since no infrastructure is modified.
	if strings.Contains(planOutput, "Changes to Outputs:") && !strings.Contains(planOutput, "Plan:") {
		return
	}

	resourceCount := terraform.GetResourceCount(t, planOutput)
	assert.Zero(t, resourceCount.Add, "Expected zero resources to add, got ", resourceCount.Add)
	assert.Zero(t, resourceCount.Change, "Expected zero resources to change, got ", resourceCount.Change)
	assert.Zero(t, resourceCount.Destroy, "Expected zero resources to destroy, got ", resourceCount.Destroy)
}
