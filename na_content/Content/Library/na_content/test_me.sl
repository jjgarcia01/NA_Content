namespace: na_content
flow:
  name: test_me
  workflow:
    - matt_na:
        do:
          na_content.matt_na:
            - username: jj.garcia
            - password:
                value: 'MFS0ftware#'
                sensitive: true
            - target: adelaide
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
      matt_na:
        x: 200
        'y': 160
        navigate:
          aa06b684-c755-3ad8-f413-f121b0df7b14:
            targetId: cbd8841d-88f8-3f31-dc3e-52392dfd151c
            port: SUCCESS
    results:
      SUCCESS:
        cbd8841d-88f8-3f31-dc3e-52392dfd151c:
          x: 440
          'y': 160
