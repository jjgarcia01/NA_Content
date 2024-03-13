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
          - SUCCESS: SUCCESS
  outputs:
    - naOutput: '${naOutput}'
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      execute_na_action:
        x: 280
        'y': 160
        navigate:
          2a34dd9d-b034-c004-1634-9a9ba03b5c07:
            targetId: ad0c5232-107b-9df0-d7b4-43ad6650935b
            port: SUCCESS
    results:
      SUCCESS:
        ad0c5232-107b-9df0-d7b4-43ad6650935b:
          x: 480
          'y': 160
