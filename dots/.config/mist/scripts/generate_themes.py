#!/usr/bin/env python3
import os
import json

def main():
    mist_dir = os.path.expanduser("~/.config/mist")
    themes_dir = os.path.join(mist_dir, "themes")
    themes_list = []

    valid_exts = [".png", ".jpg", ".jpeg", ".webp", ".gif", ".svg"]

    if os.path.isdir(themes_dir):
        for entry in sorted(os.listdir(themes_dir)):
            theme_path = os.path.join(themes_dir, entry)

            if os.path.isdir(theme_path):
                wallpapers_dir = os.path.join(theme_path, "wallpapers")
                wallpapers = []

                if os.path.isdir(wallpapers_dir):
                    for file in sorted(os.listdir(wallpapers_dir)):
                        file_path = os.path.join(wallpapers_dir, file)

                        if os.path.isfile(file_path) and os.path.splitext(file.lower())[1] in valid_exts:
                            wallpapers.append(file)

                themes_list.append({
                    "name": entry,
                    "wallpapers": wallpapers
                })

    output_path = os.path.join(mist_dir, "themes.json")
    try:
        with open(output_path, "w") as f:
            json.dump({"themes": themes_list}, f, indent=2)
        print(f"Generated themes.json with {len(themes_list)} themes")

    except Exception as e:
        print(f"Error writing themes.json: {e}")

if __name__ == "__main__":
    main()
