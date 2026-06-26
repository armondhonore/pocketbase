# Nexlayer — pocketbase

<!-- nexlayer:meta version=1 analyzed=2026-06-26T18:48:40Z repo=https://github.com/armondhonore/pocketbase branch=nexlayer -->

> **For AI agents (Claude Code, Cursor, Gemini CLI, Copilot):**
> This file is the **project context** for this Nexlayer deployment — tech stack, env vars, secrets, live URL.
> For full platform detail (nexlayer.yaml schema, Dockerfile rules, CI/CD, task recipes) read **`nexlayer.skills`** in this repo.
>
> **Critical rules (full detail in `nexlayer.skills`):**
> - Inter-pod refs: `${podName:port}` only — never `localhost` or bare hostnames
> - Docker Hub images: prefix with `mirror.gcr.io/library/` — bare tags fail on the cluster
> - Secrets: set in the Nexlayer dashboard — never commit to `nexlayer.yaml` or Dockerfile
>
> **This file:** `agent-managed` sections update automatically. `user-editable` sections (Local Development Setup, Nexlayer Deployment Plan, Build Notes) are yours — preserved across re-analysis.

## Project Summary
<!-- nexlayer:section agent-managed=project_summary -->
PocketBase is an open-source Go backend that combines a SQLite database, real-time subscriptions, user authentication, and an admin dashboard into a single executable.
<!-- nexlayer:end -->

## Technology Stack
<!-- nexlayer:section agent-managed=tech_stack -->
| Name | Kind | Version | Detected From |
|------|------|---------|---------------|
| Go | language | 1.25.0 | go.mod |
| SQLite | database | modernc.org/sqlite v1.52.0 | go.mod |
<!-- nexlayer:end -->

## Repository Structure
<!-- nexlayer:section agent-managed=structure_map -->
- cmd/ — Entry point for the application
- core/ — Core business logic and backend engine
- apis/ — REST API definitions and handlers
- ui/ — Admin dashboard frontend assets
- migrations/ — Database schema migrations
<!-- nexlayer:end -->

## External Services Required
<!-- nexlayer:section agent-managed=external_deps -->
_No external services detected._
<!-- nexlayer:end -->

## Local Development Setup
<!-- nexlayer:section user-editable=local_setup -->
### Prerequisites

- Go >= 1.25.0
- Make

### Steps

1. `go mod download` — Download Go dependencies
2. `make build` — Build the PocketBase binary using the provided Makefile
3. `./pocketbase serve` — Start the backend server

<!-- nexlayer:end -->

## Nexlayer Setup
<!-- nexlayer:section agent-managed=nexlayer_setup -->
### Pod Environment Variables

| Pod | Variable | Value | Kind |
|-----|----------|-------|------|
| `app` | `PORT` | `"8090"` | plain |

### nexlayer.yaml

```yaml
application:
  name: pocketbase
  pods:
    - name: app
      image: "registry.nexlayer.io/user_01kece1xyh817dwff7wnarhkxd/pocketbase:9f0542f-fix1"
      path: /pb_data
      servicePorts:
        - 8090
      vars:
        PORT: "8090"
```

<!-- nexlayer:end -->

## Nexlayer Deployment Plan
<!-- nexlayer:section user-editable=deployment_plan -->
### Pod Topology

| Pod | Image | Port | Role |
|-----|-------|------|------|
| pocketbase | mirror.gcr.io/library/golang:1.25-alpine | 8090 | web |
| pocketbase-db | mirror.gcr.io/library/alpine:latest | 0 | database |

### Deployment notes

- Per Nexlayer Rule 4, the SQLite database is decoupled into a separate storage pod (pocketbase-db) using a shared volume to ensure data persistence separate from the application binary.
- The application pod connects to the database storage via a mounted volume from the pocketbase-db pod.
- All images use the mirror.gcr.io/library prefix to comply with Nexlayer naming constraints.

<!-- nexlayer:end -->

## Build Notes
<!-- nexlayer:section user-editable=build_notes -->
<!-- Add notes for future builds here — preserved across re-analysis -->
<!-- nexlayer:end -->

## Nexlayer Configuration
<!-- nexlayer:section agent-managed=nexlayer_config -->
**Last deployed:** 2026-06-26T18:50:46Z  
**Live URL:** https://relaxed-weasel-pocketbase.cloud.nexlayer.ai  
**Runtime:**  · **Port:** auto-detected  
**Deploy branch:** nexlayer  

```yaml
application:
  name: pocketbase
  pods:
    - name: app
      image: "registry.nexlayer.io/user_01kece1xyh817dwff7wnarhkxd/pocketbase:9f0542f-fix1"
      path: /pb_data
      servicePorts:
        - 8090
      vars:
        PORT: "8090"
```
<!-- nexlayer:end -->

## Build History
<!-- nexlayer:section agent-managed=build_history -->
| Date | Status | Notes |
|------|--------|-------|
| 2026-06-26T18:48:40Z | analyzed | initial repo analysis |
| 2026-06-26T18:50:46Z | success | deployed https://relaxed-weasel-pocketbase.cloud.nexlayer.ai |
<!-- nexlayer:end -->
