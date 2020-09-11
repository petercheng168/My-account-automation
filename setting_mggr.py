import yaml

common = {
}

dev = {}
pa = {}
swqa = {}
prod = {}

with open("setting_mggr.yaml", "r") as yaml_file:
    setting_data = yaml.safe_load(yaml_file)

dev.update(setting_data['dev'])
pa.update(setting_data['pa'])
prod.update(setting_data['prod'])

# Variable for chose environment variable via python
env_variable = dev


def get_variables(env):
    if env == 'pa':
        pa.update(common)
        return pa
    elif env == 'prod':
        prod.update(common)
        return prod
    else:
        dev.update(common)
        return dev
