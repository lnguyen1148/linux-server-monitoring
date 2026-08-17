## Issue: Infrastructure validation reported false failures

**Problem:**  
The infrastructure validation script reported SSH, Nginx, and DNS checks as failed even though the services and network connectivity were working.

**Cause:**  
Two Bash typing errors caused incorrect validation:
- The service variable was referenced as literal text instead of expanding `$service_name`.
- Output redirection syntax was mistyped in the DNS check.

**Resolution:**  
Verified the underlying service and network commands manually, corrected the Bash syntax, and reran the validation script.

**Result:**  
All infrastructure validation checks completed successfully.
