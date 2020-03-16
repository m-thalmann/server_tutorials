# Edited lines
external_url 'https://gitlab.domain.tld' # replace domain.tld with your domain

gitlab_rails['gitlab_email_enabled'] = true
gitlab_rails['gitlab_email_from'] = 'no-reply@domain.tld'
gitlab_rails['gitlab_email_display_name'] = 'GitLab on domain.tld'

gitlab_workhorse['enable'] = true
gitlab_workhorse['listen_network'] = "tcp"
gitlab_workhorse['listen_addr'] = "127.0.0.1:8181"
gitlab_workhorse['auth_socket'] = "/var/opt/gitlab/gitlab-rails/sockets/gitlab.socket"

unicorn['socket'] = '/var/opt/gitlab/gitlab-rails/sockets/gitlab.socket'

web_server['external_users'] = ['www-data']

nginx['enable'] = false