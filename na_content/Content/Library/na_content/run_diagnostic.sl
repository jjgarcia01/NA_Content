namespace: na_content
flow:
  name: run_diagnostic
  inputs:
    - ip:
        prompt:
          type: text
    - diagnostic: show ntp status
  workflow:
    - execute_na_action:
        do:
          na_content.execute_na_action:
            - username: "${get_sp('username')}"
            - password:
                value: "${get_sp('password')}"
                sensitive: true
            - api_url: "${get_sp('api_url')}"
            - login_url: "${get_sp('login_url')}"
            - api_payload: |-
                ${{
                      "command": "run diagnostic",
                      "parameters": {
                      "ip" : ip,
                      "diagnostic" : diagnostic,
                      "runmode": "synchronous"

                      }
                    }}
        navigate:
          - SUCCESS: execute_na_action_1
    - execute_na_action_1:
        do:
          na_content.execute_na_action:
            - username: "${get_sp('username')}"
            - password:
                value: "${get_sp('password')}"
                sensitive: true
            - api_url: "${get_sp('api_url')}"
            - login_url: "${get_sp('login_url')}"
            - api_payload: |-
                ${{
                      "command": "list diagnostic",
                      "parameters": {
                      "ip" : ip,
                      "diagnostic" : diagnostic

                      }
                    }}
        navigate:
          - SUCCESS: execute_na_action_2
    - execute_na_action_2:
        do:
          na_content.execute_na_action:
            - username: "${get_sp('username')}"
            - password:
                value: "${get_sp('password')}"
                sensitive: true
            - api_url: "${get_sp('api_url')}"
            - login_url: "${get_sp('login_url')}"
            - api_payload: |-
                ${{
                      "command": "run diagnostic",
                      "parameters": {
                      "ip" : ip,
                      "diagnostic" : diagnostic,
                      "runmode": "synchronous"

                      }
                    }}
        navigate:
          - SUCCESS: SUCCESS
  outputs:
    - flow_output_0
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      execute_na_action:
        x: 40
        'y': 160
      execute_na_action_1:
        x: 240
        'y': 160
      execute_na_action_2:
        x: 440
        'y': 160
        navigate:
          ccd6e5ba-f972-878f-29bb-c2904ed205fd:
            targetId: 90c2e9f2-5bef-3c56-92f9-45c7a95af286
            port: SUCCESS
    results:
      SUCCESS:
        90c2e9f2-5bef-3c56-92f9-45c7a95af286:
          x: 640
          'y': 160
