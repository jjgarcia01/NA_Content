namespace: na_content
flow:
  name: execute_windows_healthcheck
  workflow:
    - Get_csrf_token:
        do:
          io.cloudslang.base.http.http_client_get:
            - url: 'https://rpaoo.advantageinc.org:8443/oo/rest/version'
            - auth_type: Basic
            - username: "${get_sp('username')}"
            - password:
                value: "${get_sp('password')}"
                sensitive: true
            - trust_all_roots: 'true'
            - x_509_hostname_verifier: allow_all
        publish:
          - csrf_token: "${cs_replace(cs_replace(cs_regex(response_headers,\"X-CSRF-TOKEN:.*\\n\"),\"X-CSRF-TOKEN: \",\"\"),\"\\n\",\"\")}"
        navigate:
          - SUCCESS: Execute_OO_flow
          - FAILURE: on_failure
    - Execute_OO_flow:
        do:
          io.cloudslang.base.http.http_client_post:
            - url: 'https://rpaoo.advantageinc.org:8443/oo/rest/v1/executions'
            - auth_type: Basic
            - username: "${get_sp('username')}"
            - password:
                value: "${get_sp('password')}"
                sensitive: true
            - trust_all_roots: 'true'
            - x_509_hostname_verifier: allow_all
            - headers: |-
                ${'''X-CSRF-TOKEN: '''+csrf_token+'''
                Content-Type: application/json'''}
            - body: |-
                ${'''{
                    "uuid":"3541d63f-603a-449b-9d43-8e57d7d61482",
                    "runName": "Windows Health Check",
                    "inputs": {
                        "host": "localhost",
                        "notifyMethod": "None"
                    }
                }'''}
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      Get_csrf_token:
        x: 40
        'y': 120
      Execute_OO_flow:
        x: 280
        'y': 120
        navigate:
          c287d738-6cda-cb52-ad2d-74eb072adebd:
            targetId: 28016bd0-5d5d-a9e1-3642-479deac1fc76
            port: SUCCESS
    results:
      SUCCESS:
        28016bd0-5d5d-a9e1-3642-479deac1fc76:
          x: 480
          'y': 120
