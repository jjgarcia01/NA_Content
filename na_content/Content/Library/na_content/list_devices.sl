namespace: na_content
flow:
  name: list_devices
  inputs:
    - target: adelaide
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
                ${'''
                    {
                      "command" : "list device",
                      "parameters": {
                       "host" : "'''+ target +'''"
                      }
                    }'''}
        publish:
          - naOutput
        navigate:
          - SUCCESS: json_path_query
    - json_path_query:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${naOutput}'
            - json_path: '[0].hostName'
        publish:
          - hostname: '${return_result}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - naOutput: '${naOutput}'
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      execute_na_action:
        x: 40
        'y': 160
      json_path_query:
        x: 320
        'y': 160
        navigate:
          d825b67c-21f7-5197-1603-0bf07c10d54f:
            targetId: ad0c5232-107b-9df0-d7b4-43ad6650935b
            port: SUCCESS
    results:
      SUCCESS:
        ad0c5232-107b-9df0-d7b4-43ad6650935b:
          x: 560
          'y': 160
