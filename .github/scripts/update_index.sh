#!/bin/bash
set -euo pipefail

HTML_FILE="index.html"

TODO_TASKS=$(awk '
    /^ToDo Tasks:$/ { printing = 1; next }
    /^Done Tasks:$/ { printing = 0 }
    printing && NF
' "$1")

DONE_TASKS=$(awk '
    /^Done Tasks:$/ { printing = 1; next }
    printing && NF
' "$1")

UNIT_TEST_RESULTS=$(cat "$2")

update_pre() {
    local section_id="$1"
    local content="$2"

    SECTION_ID="$section_id" SECTION_CONTENT="$content" \
    perl -0777 -i -pe '
        BEGIN {
            $id = $ENV{"SECTION_ID"};
            $text = $ENV{"SECTION_CONTENT"};
            $text =~ s/&/&amp;/g;
            $text =~ s/</&lt;/g;
            $text =~ s/>/&gt;/g;
        }
        s{<pre id="\Q$id\E">.*?</pre>}
         {qq{<pre id="$id">\n$text\n</pre>}}gse;
    ' "$HTML_FILE"
}

update_pre "pending" "$TODO_TASKS"
update_pre "completed" "$DONE_TASKS"
update_pre "unittest" "$UNIT_TEST_RESULTS"

echo "HTML report updated successfully."
