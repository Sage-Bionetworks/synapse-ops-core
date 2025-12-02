# synapse-ops-core
Synapse Ops scripts and workflows, and Code Pipelines for running them

Pipelines can see `/synapse/admin-pat` in Secrets Manager.


The scripts for the ops' jobs are in the `scripts/` folder.
Each is called from a workflow invoked via `on: workflow_call` from another repository.
The calling repository will provide an AWS role it's authorized to use. The code pipeline will be set up in the AWS account for that role,
so that it's not available to any other.  (This avoids the possibility of confusing 'dev' and 'prod' operations.)
