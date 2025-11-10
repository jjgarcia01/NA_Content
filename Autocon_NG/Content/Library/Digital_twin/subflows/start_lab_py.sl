namespace: Digital_twin.subflows
operation:
  name: start_lab_py
  inputs:
    - username: "${get_sp('eve_admin_user_NG')}"
    - password: "${get_sp('eve_admin_password_NG')}"
    - eveng_network_ip: "${get_sp('eveng_network_ip_NG')}"
    - labPath
  python_action:
    use_jython: false
    script: "def execute(username,password,eveng_network_ip,labPath):\n\n    from evengsdk.client import EvengClient\n    import logging\n    import os\n\n############################################################################\n# Start of main\n############################################################################\n    vendorList = []\n    ipList = []  \n\n# Start the logging\n    logger = logging.getLogger(__name__)\n    logging.basicConfig(filename='/tmp/eve.log', level=logging.INFO)\n\n# Login to eveng\n    client = EvengClient(eveng_network_ip, log_file=\"test.log\", ssl_verify=False, protocol=\"https\")\n    client.disable_insecure_warnings()  # disable warnings for self-signed certificates\n    client.login(username=username, password=password)\n    client.set_log_level(\"DEBUG\")\n\n    # Start all of the provisioned nodes   \n    client.api.start_all_nodes(labPath)   # Time to power on the virtual lab   \n    client.logout()\n\n    return"
  results:
    - SUCCESS
