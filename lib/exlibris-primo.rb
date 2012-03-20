PATH = File.dirname(__FILE__) + "/exlibris-primo/"
[ 
  'rest',
  'record',
  'patron',
  'bor_auth'
].each do |library|
  require PATH + library
end