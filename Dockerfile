# Kaneo for Railway: the official bundled image (web UI + API), pinned by version and digest.
# Upstream: https://github.com/usekaneo/kaneo (release v2.49.0)
FROM ghcr.io/usekaneo/kaneo:2.49.0@sha256:cd1826b1aba3ce736015cadf6f6c975d923aac00f4b6aaa7aedb29bc722dae49

# nginx serves the web app and proxies /api to the API on 127.0.0.1:1337.
# Railway routes the public domain to this port.
EXPOSE 5173

# Upstream entrypoint: derives KANEO_API_URL from KANEO_CLIENT_URL, runs the
# database migrations, starts the API and then nginx.
CMD ["/usr/local/bin/kaneo-entrypoint.sh"]
