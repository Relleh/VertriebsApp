-- Insert 20 test records with varying day_status values
-- TestDatensatz as owner_name, varying dates and day_status

INSERT INTO reports (
    date, 
    owner_oid, 
    owner_name, 
    customer_no, 
    customer_name, 
    classification, 
    short_report, 
    additional_note, 
    is_new_customer, 
    is_new_account, 
    overnight, 
    day_status,
    created_at,
    updated_at
) VALUES 
    ('2025-01-15', 'test001', 'TestDatensatz', 'K1001', 'Testfirma GmbH', 'A', 'Produktpräsentation durchgeführt', 'Großes Interesse', false, false, false, 'MOBILE', NOW(), NOW()),
    ('2025-01-15', 'test001', 'TestDatensatz', 'K1002', 'Beispiel AG', 'B', 'Vertragsverhandlung', 'Folgetermin vereinbart', false, true, false, 'MOBILE', NOW(), NOW()),
    ('2025-01-16', 'test001', 'TestDatensatz', 'K1003', 'Muster & Co KG', 'C', 'Büroarbeit Angebotsstellung', 'Angebot versandt', false, false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-16', 'test001', 'TestDatensatz', 'K1004', 'Demo Solutions', 'A', 'Telefonkonferenz', 'Remote Meeting', false, false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-17', 'test001', 'TestDatensatz', 'K1005', 'Test Industries', 'B', 'Krankheitsbedingt ausgefallen', 'Termin verschoben', false, false, false, 'PREVENTED', NOW(), NOW()),
    ('2025-01-18', 'test001', 'TestDatensatz', 'K1006', 'Sample Corp', 'C', 'Kundenbesuch vor Ort', 'Produktvorführung', true, false, true, 'MOBILE', NOW(), NOW()),
    ('2025-01-19', 'test001', 'TestDatensatz', 'K1007', 'Probe GmbH', 'A', 'Messevorbereitung', 'Materialien vorbereitet', false, false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-20', 'test001', 'TestDatensatz', 'K1008', 'Versuch AG', 'B', 'Außentermin Süddeutschland', 'Lange Anfahrt', false, false, true, 'MOBILE', NOW(), NOW()),
    ('2025-01-21', 'test001', 'TestDatensatz', 'K1009', 'Pilot Systems', 'C', 'Urlaub', 'Abwesend', false, false, false, 'PREVENTED', NOW(), NOW()),
    ('2025-01-22', 'test001', 'TestDatensatz', 'K1010', 'Trial Tech', 'A', 'Bürotag Kalkulation', 'Preise aktualisiert', false, false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-23', 'test001', 'TestDatensatz', 'K1011', 'Experiment Ltd', 'B', 'Kundenbesuche Region Nord', 'Drei Termine', false, true, false, 'MOBILE', NOW(), NOW()),
    ('2025-01-24', 'test001', 'TestDatensatz', 'K1012', 'Dummy Data AG', 'C', 'Verwaltungsaufgaben', 'Reports erstellt', false, false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-25', 'test001', 'TestDatensatz', 'K1013', 'Mock Solutions', 'A', 'Fortbildung', 'Schulung besucht', false, false, false, 'PREVENTED', NOW(), NOW()),
    ('2025-01-26', 'test001', 'TestDatensatz', 'K1014', 'Stub Services', 'B', 'Außendienst Region West', 'Neukundenakquise', true, true, true, 'MOBILE', NOW(), NOW()),
    ('2025-01-27', 'test001', 'TestDatensatz', 'K1015', 'Placeholder Inc', 'C', 'Büroarbeit Dokumentation', 'CRM gepflegt', false, false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-28', 'test001', 'TestDatensatz', 'K1016', 'Example Enterprise', 'A', 'Großkundentermin', 'Vertragsabschluss', false, false, false, 'MOBILE', NOW(), NOW()),
    ('2025-01-29', 'test001', 'TestDatensatz', 'K1017', 'Instance GmbH', 'B', 'Teammeeting', 'Strategiebesprechung', false, false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-30', 'test001', 'TestDatensatz', 'K1018', 'Case Study AG', 'C', 'Außentermin abgesagt', 'Kunde verhindert', false, false, false, 'PREVENTED', NOW(), NOW()),
    ('2025-01-31', 'test001', 'TestDatensatz', 'K1019', 'Scenario Systems', 'A', 'Jahresabschluss Vorbereitung', 'Zahlen analysiert', false, false, false, 'OFFICE', NOW(), NOW()),
    ('2025-02-01', 'test001', 'TestDatensatz', 'K1020', 'Blueprint Tech', 'B', 'Kundentour Ost', 'Fünf Besuche', true, false, true, 'MOBILE', NOW(), NOW());