#!/bin/bash

# Log in to Azure
az login

# Set the subscription to use
az account set --subscription <your_subscription_id>

# Create a resource group for the VNet and server
az group create --name myResourceGroup --location eastus

# Create a VNet with a private IP address space
az network vnet create --name myVnet --resource-group myResourceGroup --address-prefix 10.0.0.0/16 --subnet-name mySubnet --subnet-prefix 10.0.0.0/24

# Create a virtual network interface card (NIC)
az network nic create --name myNIC --resource-group myResourceGroup --vnet-name myVnet --subnet mySubnet --private-ip-address 10.0.0.5

# Create a virtual machine
az vm create --name myVM --resource-group myResourceGroup --location eastus --nics myNIC --image UbuntuLTS --admin-username myUsername --admin-password myPassword

# Open port 22 on the network security group to allow SSH access
az vm open-port --port 22 --resource-group myResourceGroup --name myVM
