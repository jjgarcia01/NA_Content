namespace: demo.NA_actions
flow:
  name: change_login_banner
  workflow:
    - deploy_changeplan:
        do:
          demo.actions.deploy_changeplan:
            - script_name: Banner_Login
            - target: adelaide
        navigate:
          - SUCCESS: SUCCESS
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      deploy_changeplan:
        x: 200
        'y': 240
        navigate:
          87bc3635-769a-2ffa-e8c0-0720e73d0f46:
            targetId: ab4768e3-9c70-d3e6-e010-2e3ee668ac6c
            port: SUCCESS
    results:
      SUCCESS:
        ab4768e3-9c70-d3e6-e010-2e3ee668ac6c:
          x: 560
          'y': 240
