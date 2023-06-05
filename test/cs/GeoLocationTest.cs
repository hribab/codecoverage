using System;
using Xunit;
using Algorithms.Other;

namespace Algorithms.Tests.Other
{
    public class GeoLocationTest
    {
        [Fact]
        public void CalculateDistanceFromLatLng_SamePoint_ShouldReturnZero()
        {
            // Arrange
            double lat1 = 0;
            double lng1 = 0;
            double lat2 = 0;
            double lng2 = 0;

            // Act
            double result = GeoLocation.CalculateDistanceFromLatLng(lat1, lng1, lat2, lng2);

            // Assert
            Assert.Equal(0, result);
        }

        [Fact]
        public void CalculateDistanceFromLatLng_NorthAndSouthPole_ShouldReturnCorrectDistance()
        {
            // Arrange
            double lat1 = 90;
            double lng1 = 0;
            double lat2 = -90;
            double lng2 = 0;

            // Act
            double result = GeoLocation.CalculateDistanceFromLatLng(lat1, lng1, lat2, lng2);

            // Assert: North and South Pole distance should be EarthRadiusKm * 2 * 1000
            Assert.Equal(GeoLocation.EarthRadiusKm * 2000, result);
        }

        [Fact]
        public void CalculateDistanceFromLatLng_SimplePoints_ShouldReturnCorrectDistance()
        {
            // Arrange
            double lat1 = 0;
            double lng1 = 0;
            double lat2 = 1;
            double lng2 = 1;

            // Act
            double result = GeoLocation.CalculateDistanceFromLatLng(lat1, lng1, lat2, lng2);

            // Assert
            Assert.Equal(157249.43, Math.Round(result, 2));
        }

        [Fact]
        public void CalculateDistanceFromLatLng_LongitudinalAntipodes_ShouldReturnCorrectDistance()
        {
            // Arrange
            double lat1 = 0;
            double lng1 = 0;
            double lat2 = 0;
            double lng2 = 180;

            // Act
            double result = GeoLocation.CalculateDistanceFromLatLng(lat1, lng1, lat2, lng2);

            // Assert: Longitudinal antipodes distance should be EarthRadiusKm * Math.PI * 1000
            Assert.Equal(GeoLocation.EarthRadiusKm * Math.PI * 1000, result);
        }

        [Fact]
        public void CalculateDistanceFromLatLng_LatitudinalAntipodes_ShouldReturnCorrectDistance()
        {
            // Arrange
            double lat1 = 0;
            double lng1 = 0;
            double lat2 = 0;
            double lng2 = -180;

            // Act
            double result = GeoLocation.CalculateDistanceFromLatLng(lat1, lng1, lat2, lng2);

            // Assert: Latitudinal antipodes distance should be EarthRadiusKm * Math.PI * 1000
            Assert.Equal(GeoLocation.EarthRadiusKm * Math.PI * 1000, result);
        }
    }
}