module Fyrotable
  module ViewHelpers        
    def fyrotable(name, records, options = {})
      table = Fyrotable.registered_tables[name]
      table.options.merge!(options)

      thead = content_tag :thead do
        content_tag :tr do
          table.visible_columns.each do |column|
            concat content_tag :th, (column.options[:header] ? column.options[:header] : column.name.to_s.titleize), class: column.options[:class]
          end
        end
      end

      tbody = content_tag :tbody do
        records.each do |record|
          row = content_tag :tr, id: "#{record.class.name.underscore.dasherize}-#{record.id}" do
            table.visible_columns.each do |column|
              if column.block.nil?
                concat(content_tag :td, record.send(column.name), class: column.options[:class])
              else
                concat(content_tag :td, self.instance_exec(record, &column.block), class: column.options[:class])
              end
            end        
          end

          concat(row)
        end
      end

      content_tag :table, thead.concat(tbody), class: table.options[:class]
    end
  end
end
