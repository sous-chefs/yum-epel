# frozen_string_literal: true

name 'yum-epel'

default_source :supermarket

run_list 'recipe[test::default]'

named_run_list :default, 'recipe[test::default]'
named_run_list :all, 'recipe[test::all]'

cookbook 'yum-epel', path: '.'
cookbook 'test', path: 'test/cookbooks/test'
