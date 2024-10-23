# OIDC Verification Example in Ruby

This shows how to verify the OIDC JWT token used by GitHub in a GitHub Action Workflow.

Running this example in GitHub Actions will test the JWT token returned by GitHub. If the script completes without an error, then the key was verified successfully.

## Note

Do not output the JWT payload for any production application.
