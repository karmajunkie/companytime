module FeatureHelpers
  module UtilityMethods
    def true_or_false(value)
      return true if value =~ /yes/i
      false
    end
    
    def find_email(email_address, table=nil)

      ActionMailer::Base.deliveries.detect do |email| 
        status = true
        if(!email.bcc.blank?)
          status &&= email.bcc.include?(email_address)
        end
        if(!email.to.blank?)
          status &&= email.to.include?(email_address)
        end

        unless table.nil?
          table.rows.each do |row|
            field, value = row.first, row.last
            case field
            when /subject/
              status &&= email.subject =~ /#{Regexp.escape(value)}/
            when /body contains$/
              status &&= email.body =~ /#{Regexp.escape(value)}/
            when /body does not contain$/
              status &&= !(email.body =~ /#{Regexp.escape(value)}/)
            when /attachments/
              filenames = email.attachments
              status &&= !filenames.nil? && value.split(',').all?{|m| filenames.map(&:original_filename).include?(m) }
            else
              raise "The field #{field} is not supported, please update this step if you intended to use it."
            end
          end
        end
        status
      end
      
    end
  end
end

World(FeatureHelpers::UtilityMethods)