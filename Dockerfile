FROM ghcr.io/actions/actions-runner:2.338.2

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential ca-certificates curl git jq pkg-config libssl-dev \
        python3 python3-venv xxd zstd \
    && rm -rf /var/lib/apt/lists/*

USER runner
