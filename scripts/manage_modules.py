#!/usr/bin/env python3
import sys
import json
import subprocess
import tempfile
import os

# Determine root directory (where this script's parent is)
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
ROOT_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, ".."))
CONFIG_PATH = os.path.join(ROOT_DIR, "configs", "config.json")


def run_terraform(module_name, variables, action="apply"):
    """
    Run Terraform (apply or destroy) at the root level, targeting a specific module.
    """
    print(f"\n🚀 Running Terraform for module: {module_name}")

    # Initialize Terraform in the root
    print(f"📂 Working directory: {ROOT_DIR}")
    init_process = subprocess.run(
        ["terraform", "init", "-input=false"],
        cwd=ROOT_DIR
    )
    if init_process.returncode != 0:
        print(f"❌ Terraform init failed in root directory")
        return

    # Prepare variables - only include the module's variables plus the enable flag
    module_vars = variables.copy()
    module_vars[f"enable_{module_name}"] = True

    # Create a temporary var-file
    with tempfile.NamedTemporaryFile(mode="w", delete=False, suffix=".tfvars.json") as tmpfile:
        json.dump(module_vars, tmpfile, indent=2)
        tmpfile_path = tmpfile.name

    try:
        # Select command
        if action in ["apply", "deploy"]:
            cmd = [
                "terraform", "apply", "-auto-approve",
                f"-var-file={tmpfile_path}",
                f"-target=module.{module_name}",
                "-compact-warnings"  # Reduce warning verbosity
            ]
        elif action == "destroy":
            cmd = [
                "terraform", "destroy", "-auto-approve",
                f"-var-file={tmpfile_path}",
                f"-target=module.{module_name}",
                "-compact-warnings"
            ]
        else:
            print(f"❌ Unknown action: {action}")
            return

        # Run command in ROOT_DIR
        print(f"🔧 Executing: {' '.join(cmd)}")
        process = subprocess.run(cmd, cwd=ROOT_DIR)
        if process.returncode == 0:
            print(f"✅ Module '{module_name}' {action} completed successfully!")
        else:
            print(f"❌ Error during {action} for module '{module_name}'")

    finally:
        # Clean up temp file
        if os.path.exists(tmpfile_path):
            os.remove(tmpfile_path)


def main():
    if len(sys.argv) < 2:
        print("Usage: python manage_modules.py [apply|destroy] [module_name1 module_name2 ... | all]")
        sys.exit(1)

    action = sys.argv[1]
    targets = sys.argv[2:] if len(sys.argv) > 2 else ["all"]

    # Load config.json
    if not os.path.exists(CONFIG_PATH):
        print(f"❌ Config file not found at: {CONFIG_PATH}")
        sys.exit(1)
    
    with open(CONFIG_PATH) as f:
        configs = json.load(f)

    # Determine which modules to run
    if "all" in targets:
        selected_modules = list(configs.keys())
    else:
        selected_modules = targets

    print(f"📋 Selected modules: {', '.join(selected_modules)}")
    print(f"🎯 Action: {action}")
    print(f"📁 Root directory: {ROOT_DIR}")

    for module in selected_modules:
        if module not in configs:
            print(f"❌ Module '{module}' not found in config.json — skipping")
            continue
        run_terraform(module, configs[module], action)

    print(f"\n🎉 All operations completed!")


if __name__ == "__main__":
    main()