% File : dataModule.m
% Description : Defines the data module class

classdef DataModule
    
    % Private Members
    properties (Access = private)
        m_data_store = struct();
    end
    
    % Class Methods
    methods 
    
        % write : Writes data into the module
        function write(obj, key, value)
            obj.m_data_store.(key) = value;
        end

        % read : Reads data from the module
        function ret_data = read(obj, key)

        end

        % delete : Deletes data from the module
        function delete(obj, key)
        end

    end
end


