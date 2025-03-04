document.addEventListener("DOMContentLoaded", function () {
    loadProvinces();
});

let locationData = {}; // Biến chứa dữ liệu địa phương

// Load danh sách tỉnh/thành phố
async function loadProvinces() {
    try {
        const response = await fetch("js/tree.json");
        locationData = await response.json();

        const provinceSelect = document.getElementById("province");
        provinceSelect.innerHTML = '<option value="" hidden selected>Chọn tỉnh/thành phố</option>';

        for (const [code, province] of Object.entries(locationData)) {
            const option = document.createElement("option");
            option.value = province.name_with_type; // Lấy name_with_type làm value
            option.textContent = province.name_with_type;
            provinceSelect.appendChild(option);
        }
    } catch (error) {
        console.error("Lỗi tải danh sách tỉnh/thành phố:", error);
    }
}

// Load danh sách quận/huyện theo tỉnh đã chọn
function loadDistricts() {
    const provinceName = document.getElementById("province").value;
    const districtSelect = document.getElementById("district");
    districtSelect.innerHTML = '<option value="" hidden selected>Chọn quận/huyện</option>';

    const provinceCode = Object.keys(locationData).find(
        (key) => locationData[key].name_with_type === provinceName
    );

    if (provinceCode && locationData[provinceCode]["quan-huyen"]) {
        const districts = locationData[provinceCode]["quan-huyen"];
        for (const [code, district] of Object.entries(districts)) {
            const option = document.createElement("option");
            option.value = district.name_with_type; // Lấy name_with_type làm value
            option.textContent = district.name_with_type;
            districtSelect.appendChild(option);
        }
    }
}

// Load danh sách xã/phường theo quận/huyện đã chọn
function loadWards() {
    const provinceName = document.getElementById("province").value;
    const districtName = document.getElementById("district").value;
    const wardSelect = document.getElementById("ward");
    wardSelect.innerHTML = '<option value="" hidden selected>Chọn xã/phường</option>';

    const provinceCode = Object.keys(locationData).find(
        (key) => locationData[key].name_with_type === provinceName
    );

    if (!provinceCode) return;

    const districtCode = Object.keys(locationData[provinceCode]["quan-huyen"]).find(
        (key) => locationData[provinceCode]["quan-huyen"][key].name_with_type === districtName
    );

    if (districtCode && locationData[provinceCode]["quan-huyen"][districtCode]["xa-phuong"]) {
        const wards = locationData[provinceCode]["quan-huyen"][districtCode]["xa-phuong"];
        for (const [code, ward] of Object.entries(wards)) {
            const option = document.createElement("option");
            option.value = ward.name_with_type; // Lấy name_with_type làm value
            option.textContent = ward.name_with_type;
            wardSelect.appendChild(option);
        }
    }
}
