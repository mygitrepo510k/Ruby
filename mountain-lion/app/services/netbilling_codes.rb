class NetbillingCodes
  CODES = {
    'DECLINED' => 'The transaction is declined, please try again later or contact support@hyedating.com',
    'A/DECLINED' => 'The transaction exceeded the traffic limits.',
    'B/DECLINED' => 'The transaction contains information found in the blacklist or high risk country list.',
    'C/DECLINED' => 'The country of origin found in the high risk country list.',
    'E/DECLINED' => 'The email address in the transaction is not valid.',
    'I/DECLINED' => 'The country of origin mis-matched country specified by card holder (IP, Card, Address)',
    'J/DECLINED' => 'The transaction contains profane or otherwise suspicious information. This check is disabled in the virtual terminal.',
    'L/DECLINED' => 'The transaction failed to pass US Location Verification.',
    'R/DECLINED' => 'The transaction contained a high risk country or came from an anonymous domain.'
  }
  def self.human_code(code)
    CODES[code.upcase] || CODES['DECLINED']
  end
end
