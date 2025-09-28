#!/usr/bin/env python3
import sys
import json
import subprocess
import tempfile
import os

BASE_DIR = "modules"

def run_terraform(module_name, variables, action="apply"):
    """
    Run Terraform (apply or destroy) for a given module using a JSON var-file.
    Works for both simple (network) and complex (subnetwork) modules.
    """
    module_path = f"{BASE_DIR}/{module_name}"

    print(f"\n🚀 Initializing module: {module_name}")
    init_process = subprocess.run(
        ["terraform", "init", "-input=false"],
        cwd=module_path
    )
    if init_process.returncode != 0:
        print(f"❌ Init failed for {module_name}")
        return

    # ✅ Write variables to a temporary tfvars.json file (text mode!)
    with tempfile.NamedTemporaryFile(mode="w", delete=False, suffix=".tfvars.json") as tmpfile:
        json.dump(variables, tmpfile, indent=2)
        tmpfile_path = tmpfile.name

    try:
        if action == "apply":
            print(f"⚡ Applying {module_name}...")
            cmd = ["terraform", "apply", "-auto-approve", f"-var-file={tmpfile_path}"]
        elif action == "destroy":
            print(f"🔥 Destroying {module_name}...")
            cmd = ["terraform", "destroy", "-auto-approve", f"-var-file={tmpfile_path}"]
        else:
            print(f"❌ Unknown action: {action}")
            return

        process = subprocess.run(cmd, cwd=module_path)
        if process.returncode == 0:
            print(f"✅ {module_name} {action} completed successfully!")
        else:
            print(f"❌ Error during {action} for {module_name}")

    finally:
        os.remove(tmpfile_path)

def main():
    if len(sys.argv) < 2:
        print("Usage: python manage_modules.py [apply|destroy] [module_name|all]")
        sys.exit(1)

    action = sys.argv[1]
    target = sys.argv[2] if len(sys.argv) > 2 else "all"

    # Load config.json
    with open("config.json") as f:
        configs = json.load(f)

    if target != "all":
        if target not in configs:
            print(f"❌ Module '{target}' not found in config.json")
            sys.exit(1)
        run_terraform(target, configs[target], action)
    else:
        for module, vars_ in configs.items():
            run_terraform(module, vars_, action)


if __name__ == "__main__":
    main()
