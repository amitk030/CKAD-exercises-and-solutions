#!/bin/bash

echo "🎯 CKAD Mock Exam 1 - Final Scoring"
echo ""
echo "⏳ Processing your exam results..."
echo ""

# Wait for background script to complete scoring
while [ ! -f /tmp/scoring_complete.txt ]; do
    sleep 1
done

# Clean up the completion flag
rm -f /tmp/scoring_complete.txt

clear
# Display the score.txt file
cat score.txt

