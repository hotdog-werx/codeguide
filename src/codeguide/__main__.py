#!/usr/bin/env python3
"""
Quick and dirty script to symlink codeguide resources to .codeguide
"""
import sys
from pathlib import Path
import codeguide


def main():
    # Get the resources folder path
    resources_path = Path(codeguide.__file__).parent / 'resources'
    
    # Target symlink path in current directory
    target_path = Path.cwd() / '.codeguide'
    
    # Remove existing .codeguide if it exists
    if target_path.exists() or target_path.is_symlink():
        if target_path.is_symlink():
            target_path.unlink()
        elif target_path.is_dir():
            import shutil
            shutil.rmtree(target_path)
        else:
            target_path.unlink()
    
    # Create the symlink
    try:
        target_path.symlink_to(resources_path, target_is_directory=True)
        print(f"✅ Symlinked {resources_path} -> {target_path}")
        
        # Write version info
        version_file = target_path / 'VERSION'
        version_file.write_text(f"codeguide-local (symlinked)\n")
        
        # Symlink .editorconfig to root directory
        editorconfig_source = resources_path / 'configs' / '.editorconfig'
        editorconfig_target = Path.cwd() / '.editorconfig'
        
        # Remove existing .editorconfig if it exists
        if editorconfig_target.exists() or editorconfig_target.is_symlink():
            editorconfig_target.unlink()
        
        # Create .editorconfig symlink
        if editorconfig_source.exists():
            editorconfig_target.symlink_to(editorconfig_source)
            print(f"✅ Symlinked {editorconfig_source} -> {editorconfig_target}")
        else:
            print(f"⚠️  .editorconfig not found at {editorconfig_source}")
        
    except Exception as e:
        print(f"❌ Failed to create symlink: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()