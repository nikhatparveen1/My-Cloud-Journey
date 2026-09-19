# Day 31 — Terraform Graph + Graphviz

## Goal

Visualize the Terraform infrastructure using Graphviz.

## Tools

Terraform
Graphviz
dot

## Main Commands

terraform graph
-> Generates a dependency graph from Terraform configuration/state.

terraform graph > terraform-graph.dot
-> Saves the raw graph definition.

terraform graph | dot -Tpng > architecture.png
-> Converts the Terraform graph into a PNG image.

dot -V
-> Checks Graphviz installation.

## Graph Flow

Terraform configuration
        ↓
Terraform graph
        ↓
Graph definition
        ↓
Graphviz dot
        ↓
architecture.png

## Why This Matters

The graph helps visualize relationships and dependencies
between Terraform resources.

It helps understand how infrastructure is connected
and makes Terraform infrastructure easier to inspect.

## Important Concept

terraform graph shows Terraform resource dependencies.

It is not necessarily a complete network architecture
diagram.

## VPC Architecture

VPC
10.0.0.0/16
    |
    +--------------------+
    |                    |
    v                    v
Public Subnet        Private Subnet
10.0.1.0/24          10.0.2.0/24
    |                    |
    v                    v
Bastion EC2         Private EC2
    |                    |
    v                    v
Public Route        Private Route
Table               Table
    |                    |
    v                    v
Internet Gateway    NAT Instance
                         |
                         v
                      Internet

## Result

Generated:

architecture.png

This is the infrastructure dependency graph
generated from Terraform.
