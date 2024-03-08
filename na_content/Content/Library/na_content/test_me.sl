namespace: na_content
flow:
  name: test_me
  workflow:
    - generic_na_operation:
        do:
          na_content.generic_na_operation:
            - username: "${get_sp('username')}"
            - password:
                value: "${get_sp('password')}"
                sensitive: true
            - target: adelaide
            - api_url: "${get_sp('api_url')}"
            - login_url: "${get_sp('login_url')}"
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
      generic_na_operation:
        x: 100
        'y': 150
        navigate:
          a57814bc-b94d-1f7a-3347-c0ae312bb154:
            targetId: 1bd6e65d-d475-616d-cf43-26beb0a2ae24
            port: SUCCESS
    results:
      SUCCESS:
        1bd6e65d-d475-616d-cf43-26beb0a2ae24:
          x: 400
          'y': 150
