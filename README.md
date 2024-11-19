# Jira CLI Utilities for Enablement Team

This is a collection of scripts, notes, and utilties for working with jira. They
are not production ready out of the box and will need to be adjusted for you use
case. Don't just run them with out understanding them.

This is primarily focused on the jira-cli and aligned to the Enablement team's
jira standards

- [Jira-cli](https://github.com/ankitpokhrel/jira-cli)

## Request API Key

Atlassian cloud requires an API key. The Atlassian team requires you to be on a whitelist. Otherwise, they delete your API key every week and send you a scolding email.

Then [generate your API key](https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/).

Then proceed to `jira init`

I chose to store my key in my MacOS keychain.

## Init and Config file

`jira init` generates a config file.

`~/.config/.jira/.config.yml`

This includes reading the custom fields into a schema. To use a custom field on
the command line it changes to lower case and hyphen separated. See How can I
set custom fields on issue creation? [#346](https://github.com/ankitpokhrel/jira-cli/discussions/346)

For example:

"Acceptance Criteria" becomes `--custom acceptance-critera="string"`

## Handy Command Lines

### Create an Epic

```bash
jira epic create -n EPIC_NAME -s EPIC_TITLE -b EPIC_DESCRIPTION_BODY -l label1 -l label2 -l labelN -C EPIC_COMPONENT --no-input
```

### Create an Issue (adds story to epic)

Here's the breakdown

- -P, Parent (epic) is JKEY-1626
- -t, type Story
- -l, labels (can take many) architecture and documenations and aws
- -C, component, Documentation
- -s, subject/title includes [SCOPE] and Subject
- body.txt - the actual story content of the ticket like AS A, I WANT, SO THAT
- --custom - "Acceptance Criteria" translates to acceptance-critera

```bash
cat body.txt | jira issue create --no-input -PJKEY-1626 -tStory -larchitecture -ldocumentation -laws -C Documentation -s"[SCOPE] Subject" --custom acceptance-critera="some criteria"
```

### Change a Story's Workflow Status

You can advance tickets through the workflow with the jira cli

-> in progress

`jira issue move JKEY-1623 "In Progress"`

-> Review

`jira issue move JKEY-1623 "Review"`

-> Done, "Won't Do" (aka cancel a ticket)

 `jira issue move JKEY-1618 Done -R"Won't Do" --comment "just a test ticket"`

### Assign a Ticket to a Person

 You can use exact full name or exact email

 ```bash
 jira issue assign ISSUE-1 first.last@exampleco.com
 ```

 To unassign

 ```bash
 jira issue assign ISSUE-1 x
 ```
