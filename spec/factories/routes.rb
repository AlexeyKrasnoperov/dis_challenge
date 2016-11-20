FactoryGirl.define do
  factory :route do
    data_source 'sentinels'
    start_node 'alpha'
    end_node 'beta'
    start_time '2016-11-20 00:54:00'
    end_time '2016-11-20 02:28:00'
  end
end
