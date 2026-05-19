namespace: demo.Example
flow:
  name: list_devices_example
  inputs:
    - target: adelaide
  workflow:
    - na_action:
        do:
          demo.na_action:
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
      na_action:
        x: 160
        'y': 160
        navigate:
          7b3c8dbb-f0c2-ba19-7d29-2bfe73b7cb3b:
            targetId: ad0c5232-107b-9df0-d7b4-43ad6650935b
            port: SUCCESS
    results:
      SUCCESS:
        ad0c5232-107b-9df0-d7b4-43ad6650935b:
          x: 560
          'y': 160
