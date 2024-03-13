namespace: na_content
flow:
  name: deploy_change_plan
  inputs:
    - ip
    - scriptname
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
                      "command": "deploy change plan",
                      "parameters": {
                      "ip" : ip,
                      "name" : script_name,

                      }
                    }}
        navigate:
          - SUCCESS: SUCCESS
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      execute_na_action:
        x: 240
        'y': 160
        navigate:
          deda1192-00b6-b499-7744-a9bcf2544569:
            targetId: 90c2e9f2-5bef-3c56-92f9-45c7a95af286
            port: SUCCESS
    results:
      SUCCESS:
        90c2e9f2-5bef-3c56-92f9-45c7a95af286:
          x: 440
          'y': 160
