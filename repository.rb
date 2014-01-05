require 'pstore'
require 'singleton'

class Repository
  include Singleton	

  def initialize
	@store = PStore.new('rir.pstore')
  end

  def fetch_country_code num_type, source_type, ip_address
	@store.transaction(true) do
	  record_found = all_records.find do |record|
		record.num_type == num_type && record.source_type == source_type && record.start_num <= ip_address && record.end_num > ip_address
	  end
	  return record_found.country_code if record_found
	end
  end
  
  def all_records
	@store.roots.map do |id|
	  @store[id]
	end
  end

  def insert assignment
	@store.transaction do
      @store[assignment.object_id] = assignment
	end
  end

end
