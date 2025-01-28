<?php
// URL of the JSON file containing passwords
$jsonUrl = "https://raw.githubusercontent.com/AlahiMajnurOsama/xyz/refs/heads/main/password.json";

// Get query parameters
$providedPassword = isset($_GET['pass']) ? $_GET['pass'] : null;
$site = isset($_GET['site']) ? $_GET['site'] : null;
$debug = isset($_GET['x']) && $_GET['x'] == 1; // Debugging mode

// Fetch and decode the JSON file
$jsonContent = file_get_contents($jsonUrl);
if ($jsonContent === false) {
    header("HTTP/1.1 500 Internal Server Error");
    echo json_encode(["error" => "Unable to fetch password data."]);
    exit;
}
$passwords = json_decode($jsonContent, true);
if ($passwords === null) {
    header("HTTP/1.1 500 Internal Server Error");
    echo json_encode(["error" => "Invalid JSON format."]);
    exit;
}

// Validate password
$isValidPassword = false;
foreach ($passwords as $entry) {
    if ($entry['password'] === $providedPassword) {
        $isValidPassword = true;
        break;
    }
}
if (!$isValidPassword) {
    header("HTTP/1.1 403 Forbidden");
    echo json_encode(["error" => "Invalid password. Access denied."]);
    exit;
}

// Validate 'site' parameter
if (!$site) {
    header("HTTP/1.1 400 Bad Request");
    echo json_encode(["error" => "No site parameter provided."]);
    exit;
}
if (!filter_var($site, FILTER_VALIDATE_URL)) {
    header("HTTP/1.1 400 Bad Request");
    echo json_encode(["error" => "Invalid URL provided."]);
    exit;
}

// Enforce HTTPS
$site = preg_replace("/^http:/i", "https:", $site);

// Initialize cURL
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $site);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // Disable SSL verification
curl_setopt($ch, CURLOPT_HEADER, true); // Include headers in response
curl_setopt($ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']); // Mimic browser user-agent
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true); // Follow redirects
curl_setopt($ch, CURLOPT_TIMEOUT, 30); // Timeout

// IP Rotation (Replace with your proxy settings)
$proxies = [
    "http://proxy1_address:port",
    "http://proxy2_address:port"
];
$proxy = $proxies[array_rand($proxies)];
curl_setopt($ch, CURLOPT_PROXY, $proxy);

// Execute request
$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$contentType = curl_getinfo($ch, CURLINFO_CONTENT_TYPE);
$headerSize = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
$headers = substr($response, 0, $headerSize);
$body = substr($response, $headerSize);

curl_close($ch);

// Remove Ads (Optional: Adjust regex for different ads)
$body = preg_replace('/<script\b[^>]*>(.*?)<\/script>/is', '', $body);
$body = preg_replace('/<iframe\b[^>]*>(.*?)<\/iframe>/is', '', $body);
$body = preg_replace('/<!--.*?-->/s', '', $body);

// Debugging Mode
if ($debug) {
    echo "<pre>";
    echo "Headers:\n" . htmlspecialchars($headers) . "\n\n";
    echo "Response Body:\n" . htmlspecialchars($body);
    echo "</pre>";
    exit;
}

// Forward content type header
header("Content-Type: $contentType");
header("HTTP/1.1 $httpCode");

// Output response body
echo $body;
?>
