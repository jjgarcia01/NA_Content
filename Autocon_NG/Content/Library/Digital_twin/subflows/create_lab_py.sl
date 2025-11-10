namespace: Digital_twin.subflows
operation:
  name: create_lab_py
  inputs:
    - username: "${get_sp('eve_admin_user_NG')}"
    - password: "${get_sp('eve_admin_password_NG')}"
    - eveng_network_ip: "${get_sp('eveng_network_ip_NG')}"
    - test_lab
  python_action:
    use_jython: false
    script: |-
      def execute(username,password,eveng_network_ip,test_lab):

          from evengsdk.client import EvengClient
          import logging
          import os

      ############################################################################
      # Start of main
      ############################################################################


      # Start the logging
          logger = logging.getLogger(__name__)
          logging.basicConfig(filename='/tmp/eve.log', level=logging.INFO)

      # Login to eveng
          client = EvengClient(eveng_network_ip, log_file="test.log", ssl_verify=False, protocol="https")
          client.disable_insecure_warnings()  # disable warnings for self-signed certificates
          client.login(username=username, password=password)
          client.set_log_level("DEBUG")

          # create a lab
          lab = {"name": test_lab, "description": "Test Lab", "path": "/"}
          resp = client.api.create_lab(**lab)
          if resp['status'] != "success":
              logger.info('Lab failed to create')

          # we need the lab path to create objects in the lab
          lab_path = f"{lab['path']}{lab['name']}.unl"

          # create management network
          mgmt_cloud = {"name": "eve-mgmt", "network_type": "pnet0"}
          resp =client.api.add_lab_network(lab_path, **mgmt_cloud, left=400)
          if resp['status'] == "success":
              logger.info('add lab network success')

          client.logout()

          return { "labPath" : lab_path}
  outputs:
    - labPath
  results:
    - SUCCESS
