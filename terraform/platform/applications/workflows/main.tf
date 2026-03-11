locals {
    common = {
        project_id = var.project_id
            region     = var.region
              }
              }

              resource "google_workflows_workflow" "dbt_pipeline" {
                name            = "dbt-pipeline-workflow"
                  region          = local.common.region
                    project         = local.common.project_id
                      service_account = data.terraform_remote_state.data_platform.outputs.service_account_email

                        source_contents = <<-YAML
                            main:
                                  params: [input]
                                        steps:
                                                - init:
                                                            assign:
                                                                          - project_id: "${local.common.project_id}"
                                                                                        - region: "${local.common.region}"
                                                                                                      - jobs:
                                                                                                                        - "dbt-staging-job"
                                                                                                                                          - "dbt-intermidate-job"
                                                                                                                                                            - "dbt-marts-job"

                                                                                                                                                                    - run_staging:
                                                                                                                                                                                call: googleapis.run.v1.namespaces.jobs.run
                                                                                                                                                                                            args:
                                                                                                                                                                                                          name: $${"namespaces/" + project_id + "/jobs/" + jobs[0]}
                                                                                                                                                                                                                        location: $${region}
                                                                                                                                                                                                                                    result: staging_execution

                                                                                                                                                                                                                                            - run_intermidate:
                                                                                                                                                                                                                                                        call: googleapis.run.v1.namespaces.jobs.run
                                                                                                                                                                                                                                                                    args:
                                                                                                                                                                                                                                                                                  name: $${"namespaces/" + project_id + "/jobs/" + jobs[1]}
                                                                                                                                                                                                                                                                                                location: $${region}
                                                                                                                                                                                                                                                                                                            result: intermidate_execution

                                                                                                                                                                                                                                                                                                                    - run_marts:
                                                                                                                                                                                                                                                                                                                                call: googleapis.run.v1.namespaces.jobs.run
                                                                                                                                                                                                                                                                                                                                            args:
                                                                                                                                                                                                                                                                                                                                                          name: $${"namespaces/" + project_id + "/jobs/" + jobs[2]}
                                                                                                                                                                                                                                                                                                                                                                        location: $${region}
                                                                                                                                                                                                                                                                                                                                                                                    result: marts_execution

                                                                                                                                                                                                                                                                                                                                                                                            - return_result:
                                                                                                                                                                                                                                                                                                                                                                                                        return:
                                                                                                                                                                                                                                                                                                                                                                                                                      message: "Pipeline dbt exécutée avec succès"
                                                                                                                                                                                                                                                                                                                                                                                                                                    staging: $${staging_execution}
                                                                                                                                                                                                                                                                                                                                                                                                                                                  intermidate: $${intermidate_execution}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                marts: $${marts_execution}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                  YAML
                                                                                                                                                                                                                                                                                                                                                                                                                                                                  }
}