#!/bin/bash
echo "Creating 500 random commits from 2019-2025..."

for i in {1..500}; do
    # Generate random date between 2019-01-01 and today
    # Calculate days between 2019-01-01 and today
    start_date="2019-01-01"
    end_date=$(date "+%Y-%m-%d")
    
    # Convert to seconds since epoch
    start_seconds=$(date -d "$start_date" +%s)
    end_seconds=$(date -d "$end_date" +%s)
    
    # Random seconds between start and end
    random_seconds=$((start_seconds + RANDOM % (end_seconds - start_seconds)))
    
    # Convert back to date format
    commit_date=$(date -d "@$random_seconds" "+%Y-%m-%d %H:%M:%S")
    
    # Add content to a file
    echo "Commit $i - Date: $commit_date" >> commit_history.txt
    
    # Stage and commit with past date
    git add commit_history.txt
    git commit -m "Update: Commit number $i" --date="$commit_date" --no-edit
    
    echo "Created commit $i for date: $commit_date"
done

echo "Pushing all 500 commits to GitHub..."
git push origin main
echo "Done! Your contribution graph from 2019-2025 should be much greener!"
