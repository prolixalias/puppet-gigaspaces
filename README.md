#gigaspaces

## WORK IN PROGRESS 
I am still very much working on this, it is fairly untested, probably broken and some sort of pre alpha stage.

Be aware.
#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What is the gigaspaces module](#module-description)
3. [Setup - The basics of getting started with gigaspaces](#setup)
    * [What gigaspaces affects](#what-gigaspaces-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with gigaspaces](#beginning-with-gigaspaces)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

The Gigaspaces module allows you manage the Gigaspaces XAP agent and management nodes.

## Module Description

Gigaspaces XAP is a in-memory computing platform for the JVM, this module will install, configure and manage the service.

## Setup

### What gigaspaces affects

* service  and environment files
* package 

### Setup Requirements 

It is expected that the Gigaspaces zip files is distributed through the Puppet masters file server, in the files subdirectory to this module. 

### Beginning with gigaspaces

To install Gigaspaces XAP agent and start the service 

```puppet
	class { 'gigaspaces':
		license_key     => 'YOURLICENSEKEY',
		lookup_groups   => [ 'LG1', 'LG2' ],
		lookup_locators => [ 'LUS1', 'LUS2' ]
	}
```
To install Gigaspaces XAP management agent and start the service 

```puppet 
	class { 'gigaspaces':
		license_key        => 'YOURLICENSEKEY',
		management_machine => true,
	}
```
## Usage

All configuration should be done through the main gigaspaces class with parameters, see gigaspaces::params for default values

## Reference

## Limitations

The modules has only ever been run on EL6 machines

## Development

Fork and create a feature branch, remember to add tests if you change how the module behaves. 
