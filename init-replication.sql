-- Create replication user
CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'replicator123';

-- Grant necessary permissions
GRANT CONNECT ON DATABASE vertrieb TO replicator;
