---
name: "advanced-testplan-creator-skill"
description: 
  "Turn JIRA ticket in to review ready Test Plan. Use this when the Tester/QA lead says `Write a testplan for JIRA-1234`, then fetch the Jira, get the Acceptance Criteria. Analyse for gaps, ambiguities. Fill the standard test plan template and stop for human review before anything is treated as final."
metadata: 
  version: "1.0.0"
  author: "Vijay Gururaja"
  stlc-phase: "Test Planning"
  license: "MIT"
---

# Test Plan Generator
- You produce a **Test plan a human still has to approve** 
- never a "done" artifact

# Core Principle
- Your Job is analysis + drafting + surfacing what is missing, not silent completion. 

## When To Use
- A Jira key/text is provided and someone wants testing planned.
- Someone asks "What are the risks / edge cases / gaps in the ticket."
- Someone asks "Create a testplan for this Jira ticket."
- Somebody says "Generate a testplan for this, ticket"

## Workflow (follow in order)

### 1. Fetch the ticket
- If a JIRA Key is given (e.g. `VWO-49`), fetch it, run `scripts/fetch-jira.sh VWO-49`
- variables requried JIRA_BASE_URL, JIRA_EMAIL, JIRA_API_TOKEN are present in the .env file
- if fetching is not working, ask the user to paste the ticket body.
- **do not invent ticket content**
- Capture: Summary, Description, Acceptance Criteria, Components, Linked Issues, Attachments, Fix Version, Sprints.

### 2. Analyze the ticket for acceptance criteria
- Run the ticket throught `references/requirement-checklist.md`
- for every item, mark ✅ present · ⚠️ ambiguous · ❌ missing
- Explicitly list 
   - Missing or vague Acceptance Criteria
   - Undefined edge cases, error states, empty/limit/boundary conditions
   - Unstated non-functional needs (perf, security, a11y, i18n, permissions/roles)
   - Missing test data, environments or dependencies.
   - Ambiguos wordings that two engineers could read two ways.


### 3. Find the missing pieces and gaps
- Output this as **"Gaps & Questions for the Author"** section. This is the most valuable part - A tester's leverage is asking the question before the bug ships.

### 4. Draft the testplan
- Fill `references/test-plan-template.md` completely.
- Derive test scenarios from the Acceptance Criteria and the gaps you found. 
- Cover Positive, Negetive, Boundary and Cross-Role / Permission paths.
- Tag each scenario as P0/ P1/ P2 by risk.
- Also use the `misc/company-details.md` as reference.

### 5. Stop for human review (mandatory)
End with a **Human Review Gate**:
- Summarize what you assumed and what you could not confirm.
- List the open questions from step 2 that block sign-off
- Ask the tester to confirm/edit before the plan is considered approved.
- Do **not** proceed to write the testcases or automation until a human approves.

## Output
``` markdown
Test Plan - <JIRA-KEY>: <title>
1. Scope and Objective
2. Gaps and Questions for the Owner <-- Surface missing pieces here
3. Test Scenarios (P0/P1/P2)
4. Test Data and Environment
5. Risks and Assumptions
6. Entry / Exit Criteria
--- HUMAN REVIEW GATE ---
- Assumptions made / Open questions / "Approve or Edit before I continue
- Add the company info and Company Logo in the output. They can be found in the `misc/company-logo.jpg` and `misc/company-details.md`
- Output should be generated in the `output/` folder.
- Output a PDF file in the format "TestPlan -<JIRA-KEY> <title>"
```

## Guardrails & Security
- Never mark the plan "Final" - a human owns sign-off.
- Never fabricate Acceptance Criteria; A missing AC is a finding, not a blank to fill.
- Keep scenario's traceable: Each maps to the AC or a Gap.

## References
`references/requirement-checklist.md` - The gap analysis checklist.
`references/test-plan-template.md` - Test Plan template to fill
`misc/company-details.md` - Company details file.
`scripts/fetch-jira.sh` - Pull a ticket over the JIRA REST API
`misc/company-logo.jpg` - Company logo file.

## When Not To Use
- When No proper JIRA ticket or Ticket body is provided.
- When Test Plan is not required to be generated

## Anti Halucination Rules
- Never assume anything.
- If you have any doubt or questions, ask the user for clarification.
- **Always create a Test Plan from the Ticket given.** and ask for clarification.
- Do not invent anything. Do not do anything until it is properly required.



