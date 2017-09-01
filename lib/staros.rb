require "staros/version"
require 'logger'

module Staros
  # Your code goes here...

  module Get



  end

  module Set

    VALID_OPTIONS = [
        :login, :password, :subs_msisdn, :asr_ip
    ]

    def clear(subs_msisdn, asr_ip)
      dump=""
      dump1=""
      Net::SSH.start(asr_ip, :login, :password => :password) do |ssh|
        p result = ssh.exec!("show subscribers  msisdn #{subs_msisdn}\n")
        dump << result
        r = dump.include?("No subscribers match the specified criteria")
        if r == false
          p result2 = ssh.exec!("clear subscribers msisdn #{subs_msisdn} -no\n")
          dump1 << result2
          r2 = dump1.include?("Number of subscribers cleared")
          if r2 == false
            @result_cler = "error"
          else
            @result_cler = "cleared:#{asr_ip}"
          end
        end
      end

      return @result_cler
    end

  end


end
